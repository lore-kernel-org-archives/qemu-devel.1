Received: from eggs.gnu.org ([2001:4830:134:3::10]:34510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erUkL-0006X4-Uj
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erUkI-00025b-0g
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:24:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1erUkH-00023B-LS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:24:05 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w21KMdfT031203
	for <qemu-devel@nongnu.org>; Thu, 1 Mar 2018 15:24:04 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2genbwr4fk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 15:24:03 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 1 Mar 2018 15:24:02 -0500
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 15:23:59 -0500
MIME-Version: 1.0
In-Reply-To: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <d88f5e8f-c298-6e21-cba8-bc2a4650e64a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] tpm: Extend TPM with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

On 03/01/2018 02:59 PM, Stefan Berger wrote:
> This series of patches implements support for migrating the state of the
> external 'swtpm' TPM emulator as well as that of the TIS interface.
>
> For testing of TPM 2 (migration) please use the following git repos and
> branches:
>
> libtpms:
>     - repo: https://github.com/stefanberger/libtpms
>     - branch: tpm2-preview.rev146.v2
>
> swtpm:
>     - repo: https://github.com/stefanberger/swtpm
>     - branch: tpm2-preview.rev146.v2

Typo: -> tpm2-preview.v2


   Stefan
