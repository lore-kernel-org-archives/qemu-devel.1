Received: from eggs.gnu.org ([2001:4830:134:3::10]:39204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d85ib-0000Wr-ID
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d85iX-0005vJ-H3
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d85iX-0005v7-BP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:02:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E08583DE3C
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 14:02:18 +0000 (UTC)
Message-ID: <1494338531.22189.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 09 May 2017 16:02:11 +0200
In-Reply-To: <CABdb736fuqG1LhZYmxaZ_GMXXjTwKrQGs4M2h1Juwo=ObdyWNA@mail.gmail.com>
References: <20170421091632.30900-1-kraxel@redhat.com>
	<20170421091632.30900-5-kraxel@redhat.com>
	<CABdb736fuqG1LhZYmxaZ_GMXXjTwKrQGs4M2h1Juwo=ObdyWNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/9] vga: make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

  Hi,

> #4 cpu_physical_memory_snapshot_get_dirty (snap=3D0x555556a3b3d0,
> start=3D2148532224, length=3D511)

https://patchwork.ozlabs.org/patch/760013/

cheers,
  Gerd
