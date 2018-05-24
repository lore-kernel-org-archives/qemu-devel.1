Received: from eggs.gnu.org ([2001:4830:134:3::10]:38145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fLtD8-0004w9-O9
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fLtD4-0008MF-Mn
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:35:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fLtD4-0008KC-1R
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:35:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4OGZ0G9084230
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 12:35:24 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j60rq11f8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 12:35:24 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 24 May 2018 12:35:22 -0400
References: <20180524161435.3012991-1-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 24 May 2018 12:35:20 -0400
MIME-Version: 1.0
In-Reply-To: <20180524161435.3012991-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <541cbd53-5ccb-db5e-123b-323684724244@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 0/4] Merge tpm 2018/05/23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com

On 05/24/2018 12:14 PM, Stefan Berger wrote:
> This series of patches adds TPM emulator state migration support and a
> test case for testing (local) migration.
>
>     Stefan
>
> The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd=
466d:
>
>    Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-re=
quest' into staging (2018-05-22 09:43:58 +0100)
>
> are available in the Git repository at:
>
>    git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-05-23-=
1

EBADTAG: That should be a '-2'. I guess I will have to fix this in a v3.

 =C2=A0=C2=A0 Stefan
