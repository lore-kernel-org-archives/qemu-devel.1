Received: from eggs.gnu.org ([2001:4830:134:3::10]:33681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgJPI-0001Am-UE
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgJPF-0001Cs-V9
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:59:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgJPF-0001Cm-PL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:59:37 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D93D2C054C31
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 22:59:37 +0000 (UTC)
Message-ID: <1487717975.20449.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:59:35 +0100
In-Reply-To: <20170221141451.28305-28-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-28-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 27/30] tests: fix usb-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Di, 2017-02-21 at 18:14 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Fix the usb tests leaks.
>=20
> Spotted by ASAN.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
