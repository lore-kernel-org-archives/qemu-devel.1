Received: from eggs.gnu.org ([2001:4830:134:3::10]:55794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ehOLs-00006s-1h
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ehOKo-0004y2-0Z
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:33:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ehOKn-0004vn-CJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 18:32:01 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w11NTopg018958
	for <qemu-devel@nongnu.org>; Thu, 1 Feb 2018 18:32:00 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvaxbbpy6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 18:31:59 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 1 Feb 2018 16:31:59 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180126180816.GI25150@localhost.localdomain>
References: <20180118020157.25401-1-ehabkost@redhat.com>
	<CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
	<CAATJJ0Kwf=qMQ8Sax8d4ieFXfFrqaisd6wUSLTTLBxvSdgb5Jw@mail.gmail.com>
	<1d3ee391-bbb2-3c49-b3b0-8f189e0fd096@de.ibm.com>
	<151673132716.4211.15090159170244596259@sif>
	<20180123193118.GA4298@localhost.localdomain>
	<151674323649.4211.10355855473647907818@sif>
	<20180126012950.GA25150@localhost.localdomain>
	<151698413254.4211.16734336801467103275@sif>
	<20180126180816.GI25150@localhost.localdomain>
Date: Fri, 26 Jan 2018 12:23:06 -0600
Message-Id: <151699098657.4211.3890575797150661062@sif>
Subject: Re: [Qemu-devel] [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-ppc@nongnu.org

Quoting Eduardo Habkost (2018-01-26 12:08:16)
> It looks like there's some confusion here: I don't have
> additional proposed changes; the flag names and MSR code I
> mentioned are already merged on master (through this pull
> request).

Ah, my mistake, I thought the flags were being proposed as follow-up.
Will pull these in as is then. Thanks!

> =

> -- =

> Eduardo
>=20
