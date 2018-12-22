Received: from eggs.gnu.org ([2001:4830:134:3::10]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gaiIX-0001Sb-LE
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 09:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gaiIT-0003A2-NN
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 09:30:37 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gaiIT-00039I-Gl
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 09:30:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id x10so7901377wrs.8
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 06:30:33 -0800 (PST)
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
	<CAFEAcA-s2koSnDTC_O0_nH5Kkg4xrSALcsAR8aQXwJ-P61-eCw@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <8aca3dc8-f9cc-1913-83c8-f7fd3c4dd753@gmail.com>
Date: Sat, 22 Dec 2018 16:30:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-s2koSnDTC_O0_nH5Kkg4xrSALcsAR8aQXwJ-P61-eCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH PULL 00/31] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 12/22/18 3:59 PM, Peter Maydell wrote:
> On Sat, 22 Dec 2018 at 09:50, Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com> wrote:
>> The following changes since commit 891ff9f4a371da2dbd5244590eb35e8d803e18d8:
>>
>>    Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20181221' into staging (2018-12-21 15:49:59 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/marcel-apf/qemu tags/rdma-pull-request
>>
>> for you to fetch changes up to f1e2e38ee0136b7710a2caa347049818afd57a1b:
>>
>>    pvrdma: check return value from pvrdma_idx_ring_has_ routines (2018-12-22 11:09:57 +0200)
>>
>> ----------------------------------------------------------------
>> RDMA queue
>>   * Add support for RDMA MAD
>>   * Various fixes for the pvrdma backend
>>
>> ----------------------------------------------------------------
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes.

Done.

Thanks,
Marcel

> -- PMM
