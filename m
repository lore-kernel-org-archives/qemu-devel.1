Received: from eggs.gnu.org ([2001:4830:134:3::10]:41641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eqfcF-0002Ml-B3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eqfcA-0003ct-Fq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:48:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34022
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eqfcA-0003cj-B2
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:48:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RDm7MC011668
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:48:17 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gd7fg3amw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:48:17 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 06:48:16 -0700
References: <1519421985-18185-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAFEAcA84G9BW8bikXYLuu=m6Ca2WRmMH3VXwYvX_x32xJtQVuQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 08:48:13 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84G9BW8bikXYLuu=m6Ca2WRmMH3VXwYvX_x32xJtQVuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <7c15a021-3e7f-7096-1f01-a43f06ec2e72@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PULL v1 0/2] Merge tpm 2018/02/21 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 02/27/2018 05:13 AM, Peter Maydell wrote:
> On 23 February 2018 at 21:39, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>> This patch series adds a test case for the TPM TIS interface.
>>
>>     Stefan
>>
>> The following changes since commit a6e0344fa0e09413324835ae122c4cadd7890231:
>>
>>    Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-request' into staging (2018-02-20 14:05:00 +0000)
>>
>> are available in the git repository at:
>>
>>    git://github.com/stefanberger/qemu-tpm.git tpm-pull-2018-02-21
>>
>> for you to fetch changes up to adb0e917e6ee93631e40265ca145bc31cd3b6c9a:
>>
>>    tests: add test for TPM TIS device (2018-02-21 07:24:50 -0500)
>>
> Hi. This doesn't appear to be a signed tag; my scripts complain
>
> error: remotes/stefanberger/tpm-pull-2018-02-21: cannot verify a
> non-tag object of type commit.
I'll have to resend it.

    Stefan

>
> thanks
> -- PMM
>
