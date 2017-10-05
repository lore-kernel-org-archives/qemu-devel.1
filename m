Received: from eggs.gnu.org ([2001:4830:134:3::10]:58104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e0Bj9-0001WO-QB
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e0BiQ-0007P2-BN
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:22:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e0BiQ-0007O0-0m
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:21:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95JLjax092563
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 15:21:45 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ddsapvun1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 15:21:45 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 15:21:41 -0400
References: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1507222112-20315-11-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 5 Oct 2017 15:21:37 -0400
MIME-Version: 1.0
In-Reply-To: <1507222112-20315-11-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <0375382f-9713-c292-9ff2-32a76e0ed789@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PULL v1 10/10] specs: Describe the TPM support in
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, amarnath.valluri@intel.com, marcandre.lureau@gmail.com

On 10/05/2017 12:48 PM, Stefan Berger wrote:
> This patch adds a description of the current TPM support in QEMU
> to the specs.
>
> Several public specs are referenced via their landing page on the
> trustedcomputinggroup.org website.
>
> Signed-off-by: Stefan Berger <address@hidden>
> Reviewed-by: Laszlo Ersek <address@hidden>

This is obviously a mess-up. I'll fixed that on my github account, which 
now puts the last change at 3bfc6666c21bf9e437734bb3e90db7e5b5f6b8bf.

    Stefan
