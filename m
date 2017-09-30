Received: from eggs.gnu.org ([2001:4830:134:3::10]:49292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dyAtJ-0008Kv-Vu
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dyAtJ-000663-1F
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:04:45 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:46368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dyAtI-00064N-Qp
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:04:44 -0400
Received: by mail-wm0-x230.google.com with SMTP id m72so2632793wmc.1
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 23:04:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170930041855.10997-1-lma@suse.com>
References: <20170930041855.10997-1-lma@suse.com>
From: Carlo Arenas <carenas@gmail.com>
Date: Fri, 29 Sep 2017 23:04:42 -0700
Message-ID: <CAPUEspiDK-Hxa+kWe60CGX3JbJUdWZv=zu-tF=sNBgSnvF10Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] maint: Add scsi/qemu-pr-helper to
 .gitignore
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

there is already a similar patch going through the trivial patches flow to
correct this as shown in :

  https://patchwork.kernel.org/patch/9972285/

Carlo
