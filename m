Received: from eggs.gnu.org ([2001:4830:134:3::10]:49475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7MvK-0003Dj-Jn
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7MvG-0007J0-GW
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:44:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35386
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e7MvG-0007IG-BD
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:44:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PEfOF4131753
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:44:42 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dtvckh26c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:44:42 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 08:44:42 -0600
References: <1508908500-25274-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1ce3317d-8833-7e2e-9b4d-93acb45317a1@amsat.org>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 10:44:37 -0400
MIME-Version: 1.0
In-Reply-To: <1ce3317d-8833-7e2e-9b4d-93acb45317a1@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57a468ed-26c4-a0e4-79a0-03a84eefc65a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] Merge tpm 2017/10/24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

On 10/25/2017 09:05 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Stefan,
>
> On 10/25/2017 02:14 AM, Stefan Berger wrote:
>> *The following changes since commit 3d7196d43bfe12efe98568cb60057e2736=
52b99b:
>>
>>    Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull=
-request' into staging (2017-10-24 16:05:57 +0100)
>>
>> are available in the git repository at:
>>
>>    git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-24=
-1
>>
>> for you to fetch changes up to 298d8b81d45d2297f88d93604bd5eebfd653d6c=
f:
> The tag is correct,
>
>    $ git tag -v pull-tpm-2017-10-24-1
>    tag pull-tpm-2017-10-24-1
>    tagger Stefan Berger <stefanb@linux.vnet.ibm.com> 1508908015 -0400
>    gpg: Good signature from "Stefan Berger <stefanb@linux.vnet.ibm.com>=
"
>    Merge tpm 2017/10/24 v1
>
> However you sent it as a PATCH series, I'm not sure this will correctly
> trigger Peter's farm-building scripts.

Will resend. Was late last night...

>
> Also I suggest you to add some description such "This fixes a build
> issue using --disable-tpm" in the cover letter.

Good idea.

   Cheers,
      Stefan

>
> Regards,
>
> Phil.
>
>
