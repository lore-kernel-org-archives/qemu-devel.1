Received: from eggs.gnu.org ([2001:4830:134:3::10]:52022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG1L8-0007hq-Tr
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG1L3-0007lv-Fb
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:35:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gG1L2-0007i9-Vf
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:35:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B026C050DFB
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 12:35:40 +0000 (UTC)
Date: Fri, 26 Oct 2018 18:05:30 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181026095433.GF31390@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810261804380.8270@xnncv>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
	<nycvar.YSQ.7.76.1810251622450.11480@xnncv>
	<20181025204029.GB29995@redhat.com>
	<nycvar.YSQ.7.76.1810261237090.8270@xnncv>
	<20181026095433.GF31390@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/3] adlib: mark as insecure and
 deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

+-- On Fri, 26 Oct 2018, Daniel P. Berrang=C3=A9 wrote --+
| > No, since the adlib device is not used as much and is being deprecate=
d, I'm=20
| > not inclined to get one.
|=20
| Any security issue that affects code in QEMU that is currently being
| shipped by distros should have a CVE.
|=20
| Whether we intend to deprecate & delete it later should not be a factor
| because we are free to cancel the deprecation process at any time if we
| find a reason to keep the feature around.

Okay, will follow up with a CVE process. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
