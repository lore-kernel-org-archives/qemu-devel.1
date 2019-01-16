Received: from eggs.gnu.org ([209.51.188.92]:49521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gjj3G-00054I-8n
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gjj3E-0008TU-5o
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:08:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60580
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gjj3D-0008Mg-TI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:08:04 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0GB79Es033900
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 06:08:03 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q23br0j39-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 06:08:02 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 16 Jan 2019 11:08:02 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <b6f679bc-37cb-8b4f-d530-9dd2639f84c1@ozlabs.ru>
References: <20181119213739.773-1-farosas@linux.ibm.com>
	<20181119213739.773-2-farosas@linux.ibm.com>
	<aa441205-a985-5cdc-ee7e-c843777f8f53@redhat.com>
	<b6f679bc-37cb-8b4f-d530-9dd2639f84c1@ozlabs.ru>
Date: Wed, 16 Jan 2019 09:07:56 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87ftts273n.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] target/ppc: support single
 stepping with KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Philippe =?utf-8?Q?Mathi?= =?utf-8?Q?eu-Daud=C3=A9?= <philmd@redhat.com>, david@gibson.dropbear.id.au

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> Fabiano,
>
> Are you planning on reposting this any time soon? I am interested in the
> feature. Thanks.

Yes, I'm almost done with v3 of the series. Will probably send it later
this week.
