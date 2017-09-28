Received: from eggs.gnu.org ([2001:4830:134:3::10]:54047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dxbyh-0003dt-Dj
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dxbye-00006S-B9
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:47:59 -0400
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:55949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dxbye-000065-5q
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 12:47:56 -0400
Received: by mail-io0-x234.google.com with SMTP id z187so2089150ioz.12
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:47:56 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.4614.1506600439.14748.qemu-devel@nongnu.org>
Date: Thu, 28 Sep 2017 12:47:51 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2C519DD-C9FE-42FC-9418-CD13BC48238D@gmail.com>
References: <mailman.4614.1506600439.14748.qemu-devel@nongnu.org>
Subject: [Qemu-devel] [PATCH v7 0/6] Initial support for keycodemapdb GIT
 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>


> This patch series is an update to:
>=20
>  v1: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
>  v2: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
>  v3: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02517.html
>  v4: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02708.html
>  v5: =
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02950.html
>  v6: =
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07673.html

<snip>

These error messages appears when compiling version 7 of this patch =
series:

/bin/sh: ./scripts/git-submodule.sh: Permission denied

  GEN     module_block.h
make: *** No rule to make target `ui/input-keymap-linux-to-qcode.c', =
needed by `Makefile'.  Stop.
