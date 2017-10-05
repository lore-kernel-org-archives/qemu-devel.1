Received: from eggs.gnu.org ([2001:4830:134:3::10]:34611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e08Q1-0004B0-9x
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e08Q0-0006zQ-Ir
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:50:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e08Q0-0006yQ-Cq
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:50:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B2CD2CE92E
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 15:50:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-239.ams2.redhat.com
	[10.36.116.239])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F50A63652
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 15:50:35 +0000 (UTC)
Received: from localhost (localhost [IPv6:::1])
	by sirius.home.kraxel.org (Postfix) with ESMTP id 5257766
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 17:50:34 +0200 (CEST)
Message-ID: <1507218634.6131.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 05 Oct 2017 17:50:34 +0200
In-Reply-To: <20171005153330.19210-1-kraxel@redhat.com>
References: <20171005153330.19210-1-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] update keymaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

  Hi,

> Third patch updates all the keymaps.=C2=A0=C2=A0If you want test the ne=
w
> keymaps
> it is enough to apply just that third patch.

Oops, seems patch #3 was too big for the list.
Try fetching the bits from the git repo then:

https://www.kraxel.org/cgit/qemu/log/?h=3Dwork/xkbcommon

cheers,
  Gerd
