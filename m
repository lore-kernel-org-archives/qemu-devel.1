Received: from eggs.gnu.org ([2001:4830:134:3::10]:34183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqCYo-0004tv-EZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqCYj-0007LU-St
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqCYj-0007L2-Me
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:14:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C588181DE4
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 06:14:32 +0000 (UTC)
Date: Fri, 8 Sep 2017 14:14:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908061427.GD4511@lemon>
References: <20170907084700.952-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170907084700.952-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] buildsys: Move brlapi libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Thu, 09/07 16:47, Fam Zheng wrote:
> baum.o already receives the sdl cflags in its per object variable, do
> the same for brlapi libs to avoid cluttering libs_softmmu.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, I'll send a pull request later.

Fam
