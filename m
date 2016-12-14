Received: from eggs.gnu.org ([2001:4830:134:3::10]:55460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cH94o-00084u-T5
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cH94l-0007fQ-Rq
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:54:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cH94k-0007eH-Fk
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:54:27 -0500
Date: Wed, 14 Dec 2016 13:54:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161214125423.GB4135@noname.redhat.com>
References: <20161213214917.6436-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161213214917.6436-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Update language files for QEMU 2.8.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

Am 13.12.2016 um 22:49 hat Stefan Hajnoczi geschrieben:
> Update translation files (change created via 'make -C po update').
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Should we actually try to translate the additional string instead of
just adding it as a placeholder? I can send a de_DE patch, if you like.

And actually, what is the "Copy" menu entry supposed to do apart from
immediately crashing with a segfault, which it does for me in a qemu
process without options?

And would that crash be considered a release blocker, too?

Kevin
