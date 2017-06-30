Received: from eggs.gnu.org ([2001:4830:134:3::10]:33296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dQqnT-0001WM-S6
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dQqnQ-0003IO-Oa
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:56:59 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:44633)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dQqnQ-00039E-Ic
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 03:56:56 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9AEDA9BD86
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 09:56:48 +0200 (CEST)
References: <20170623092124.GG12089@umbus>
	<c0a0667e-8c60-a8e7-a041-caddac8c8b88@redhat.com>
	<20170628014231.GA791@pacoca>
	<a34435df-8944-ddac-e881-0a2338e4aad4@redhat.com>
	<20170628081850.GJ12089@umbus>
	<668938c1-f93e-86d1-4e4e-5715d5074587@kaod.org>
	<e0f76eb1-2388-e512-3763-26e7232b1129@redhat.com>
	<baf1e0b1-178b-28ae-f2a2-caadaaf9d213@kaod.org>
	<20170628135908.4501f0a0@bahia.lab.toulouse-stg.fr.ibm.com>
	<78fa4c41-92db-8676-b6ef-db9de9717844@redhat.com>
	<20170630071402.GF13989@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9aebd9c7-3d2d-7bd6-4010-8f8205f62f01@kaod.org>
Date: Fri, 30 Jun 2017 09:56:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170630071402.GF13989@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, sursingh@redhat.com, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, sbobroff@redhat.com, Michael Ellerman <mpe@ellerman.id.au>

>>> According to https://patchwork.ozlabs.org/patch/776052/
>>>
>>> POWER9 DD2's PVR is expected to be 0x004e1200
> 
> Uh.. I spoke to Michael Ellerman, and he said he expected 0x004e0200.
> Though he did mention there might be several variants.  Can we please
> get a definitive answer on this from IBM.

Adding Michael Ellerman in cc: but I think Greg is correct. 

C.
