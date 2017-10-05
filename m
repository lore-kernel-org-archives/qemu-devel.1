Received: from eggs.gnu.org ([2001:4830:134:3::10]:37815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09QU-0003fS-CX
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09QP-0006Vv-G8
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:55:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60698
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e09QP-0006Vm-A4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:55:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95GsS1r086424
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 12:55:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ddrnd02ty-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 12:55:01 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 12:55:01 -0400
References: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAFEAcA8XevNGXiKP+-+rNjG1g1C7cOu1e43OaMdh7P4C5Qgh8g@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 5 Oct 2017 12:54:58 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XevNGXiKP+-+rNjG1g1C7cOu1e43OaMdh7P4C5Qgh8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <5af0117d-3255-90c4-0fb3-26a82118b406@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PULL v1 00/10] Merge tpm 2017/10/04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, amarnath.valluri@intel.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

On 10/05/2017 12:53 PM, Peter Maydell wrote:
> On 5 October 2017 at 17:48, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>> The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10ea:
>>
>>    Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-10-03 16:27:24 +0100)
>>
>> are available in the git repository at:
>>
>>    git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-04-1
>>
>> for you to fetch changes up to 5e64d0182fe9d1c9caa347c5bee0a0591f9be2ef:
>>
>>    specs: Describe the TPM support in QEMU (2017-10-05 12:39:15 -0400)
>>
>> ----------------------------------------------------------------
>> Merge tpm 2017/10/04 v1
>>
> Hi; this pull request appears to be signed with a gpg key that
> isn't signed by anybody else... Are there other people you work
> with at IBM who can verify your id and sign your key for you?

Does the other person need to be part of the QEMU community?

    Stefan

>
> thanks
> -- PMM
>
