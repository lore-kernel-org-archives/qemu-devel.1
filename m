Received: from eggs.gnu.org ([2001:4830:134:3::10]:39906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSfKX-00017W-3m
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSfKT-0006m5-VN
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:43:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSfKT-0006lb-P8
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:43:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181031115242.6558-1-d.csapak@proxmox.com>
	<20181031115242.6558-4-d.csapak@proxmox.com>
Date: Fri, 30 Nov 2018 10:43:19 +0100
In-Reply-To: <20181031115242.6558-4-d.csapak@proxmox.com> (Dominik Csapak's
	message of "Wed, 31 Oct 2018 12:52:42 +0100")
Message-ID: <87o9a6lx3c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] qapi: add reason to SHUTDOWN and RESET
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

Dominik Csapak <d.csapak@proxmox.com> writes:

> this makes it possible to determine what the exact reason was for
> a RESET or a SHUTDOWN

Yes, but why is that useful?  I can guess, but the commit shouldn't make
me guess.

Please start your sentences with a capital letter and end them with
punctuation.

> this patch also fixes the iotests

> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
