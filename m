Received: from eggs.gnu.org ([2001:4830:134:3::10]:47784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx8BQ-0003HJ-13
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dx8BK-0003Rw-KV
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:59:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dx8BK-0003Rc-FZ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:59:02 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170925112917.21340-4-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 25 Sep 2017 12:29:14 +0100")
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-4-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Sep 2017 10:59:02 +0200
Message-ID: <87wp4kbjqh.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/6] migration: Check field save returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, famz@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Check the return values from vmstate_save_state for fields and also the
> return values from 'put' for fields that use that.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
