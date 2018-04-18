Received: from eggs.gnu.org ([2001:4830:134:3::10]:40372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f8gWy-0006gv-BL
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f8gWu-00084t-EO
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:25:24 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:44418
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1f8gWu-00084W-6J
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:25:20 -0400
References: <CAMxP3BSFEuknshd05kSn8EjNuv8F8aPGuNFG3qUd0Ap6GbZFrQ@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <18e4de85-274e-54aa-e34e-4fd3f82e40e2@weilnetz.de>
Date: Wed, 18 Apr 2018 08:25:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAMxP3BSFEuknshd05kSn8EjNuv8F8aPGuNFG3qUd0Ap6GbZFrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Latest v2.12.0-rc4 has compiling error, rc3 is OK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>, qemu-devel@nongnu.org

Am 18.04.2018 um 08:19 schrieb Bob Chen:
> fatal error: ui/input-keymap-atset1-to-qcode.c: No such file or directory
> 
> Build on my CentOS 7.
> 

That file is generated during the build. rc4 compiles in my test on
Debian. Did you start your build from a fresh git clone?

Stefan
