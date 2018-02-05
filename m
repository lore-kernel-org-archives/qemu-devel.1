Received: from eggs.gnu.org ([2001:4830:134:3::10]:32847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eioSR-0003lB-CX
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eioSO-0005vv-8T
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:37:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eioSN-0005vj-Vr
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:37:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w15LaIOr069448
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 16:37:42 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxxk21mye-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 16:37:11 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 5 Feb 2018 14:37:11 -0700
References: <151786561741.90.6108034647933461572@bdbb90650ae5>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 5 Feb 2018 16:37:07 -0500
MIME-Version: 1.0
In-Reply-To: <151786561741.90.6108034647933461572@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <5e038cf1-28f7-6bac-9dd2-84b599f218c4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 00/12]Interactive Boot Menu
 for DASD and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, alifm@linux.vnet.ibm.com, famz@redhat.com, david@redhat.com, cohuck@redhat.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

This was silly.=C2=A0 Last minute change on my end.=C2=A0 Consider the as=
sertion=20
removed.

On 02/05/2018 04:20 PM, no-reply@patchew.org wrote:
>
> /var/tmp/patchew-tester-tmp-k5bn7h1w/src/pc-bios/s390-ccw/libc.c: In fu=
nction =E2=80=98itostr=E2=80=99:
> /var/tmp/patchew-tester-tmp-k5bn7h1w/src/pc-bios/s390-ccw/libc.c:70:20:=
 error: comparison of unsigned expression >=3D 0 is always true [-Werror=3D=
type-limits]
>       IPL_assert(num >=3D 0, "itostr: cannot convert negative values");
>                      ^~


--=20
- Collin L Walling
