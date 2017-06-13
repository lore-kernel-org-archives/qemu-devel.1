Received: from eggs.gnu.org ([2001:4830:134:3::10]:35662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKiq2-0005QC-VM
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKiq2-0002Yz-3z
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:14:18 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKiq1-0002YQ-Uj
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:14:18 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 36so13668786wry.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 03:14:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c57bdb58-67a2-0f35-c8f8-d83e54fc72b3@de.ibm.com>
References: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
	<c57bdb58-67a2-0f35-c8f8-d83e54fc72b3@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 11:13:53 +0100
Message-ID: <CAFEAcA8p7QibbkTnB_uYcOJCRf-y2SRJ6c_0ghmkHVNuqFsXSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] s390x/kvm: various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@gmail.com>

On 8 June 2017 at 15:42, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> On 06/08/2017 03:18 PM, Christian Borntraeger wrote:
>> Peter,
>>
>> The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b04:
>>
>>   Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (2017-05-30 14:15:15 +0100)
>>
>> are available in the git repository at:
>>
>>   ssh://git@github.com/borntraeger/qemu.git tags/s390x-20170608
>
> This address is certainly better
>
>   git://github.com/borntraeger/qemu.git tags/s390x-20170608
>

Applied, thanks.

-- PMM
