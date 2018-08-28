Received: from eggs.gnu.org ([2001:4830:134:3::10]:37432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fue7v-00007e-FN
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fue7u-0004uX-TR
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:33:47 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-30-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-30-mreitz@redhat.com>
Date: Tue, 28 Aug 2018 15:33:37 +0200
Message-ID: <w514lfesjim.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 29/31] block/null: Generate
 filename even with latency-ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 11:35:26 PM CEST, Max Reitz wrote:
> While we cannot represent the latency-ns option in a filename, it is not
> a strong option so not being able to should not stop us from generating
> a filename nonetheless.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

I thought I had reviewed this one already ?

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
