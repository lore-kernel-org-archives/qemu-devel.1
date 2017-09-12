Received: from eggs.gnu.org ([2001:4830:134:3::10]:33604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1drjnj-00084h-CY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1drjnd-0006Xh-Bw
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:56:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39014
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1drjnd-0006Wh-6v
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:56:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8CBuDWV100331
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 07:56:16 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cxcm08hhe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 07:56:16 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 12 Sep 2017 12:56:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v8CBuCOv20381752
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 11:56:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E64015203F
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 11:51:21 +0100 (BST)
Received: from [9.152.222.92] (unknown [9.152.222.92])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C16A752043
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 11:51:21 +0100 (BST)
References: <b0cd3b7a-fcc8-03ed-55dd-cbdba2ff59ec@linux.vnet.ibm.com>
	<20170912131823.1f7a9e03.cohuck@redhat.com>
	<2bd6e514-9656-773c-901e-2e0f4aa299ca@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 12 Sep 2017 13:56:12 +0200
MIME-Version: 1.0
In-Reply-To: <2bd6e514-9656-773c-901e-2e0f4aa299ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <ee2c47b5-1d25-9ae3-ae22-a9abc9994b0f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Suggested Wiki Update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 12.09.2017 13:25, Thomas Huth wrote:
> On 12.09.2017 13:18, Cornelia Huck wrote:
[...]
>>
>> Looks good.
>>
>> Can you perhaps add a sentence that the base support is available with
>> 2.9 and netboot with 2.10? ('Overview' looks like a good place for
>> that.)
>=20
> FWIW, I think it would also be good to add a sentence about the need to
> specify "bootindex" somewhere (I remember trying to use "-boot n" the
> first time I wanted to use it) ...
>=20
Good points, I'll add more context ... thanks for the review.

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
