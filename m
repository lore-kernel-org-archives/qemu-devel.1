Received: from eggs.gnu.org ([209.51.188.92]:60635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvli-0003le-Sc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvlh-0004dX-E6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:46:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDvlg-0004dR-Vu
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:46:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so4546664wmi.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:46:48 -0700 (PDT)
References: <1554827719-10184-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8fs_H-gwk251mCq1V2tOBF=Mr96e4FY0aePyCre-D9NA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c2b0c36-26ce-b272-c304-89120c2de489@redhat.com>
Date: Tue, 9 Apr 2019 20:46:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8fs_H-gwk251mCq1V2tOBF=Mr96e4FY0aePyCre-D9NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3 0/5] Misc patches for QEMU 5.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4/9/19 7:25 PM, Peter Maydell wrote:
> On Tue, 9 Apr 2019 at 17:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 248987f92cfda8305d6d44ced23e173e62a8bc0e:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-04-09 10:02:30 +0100)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 3e20c81ed87cb15cd04f929b075e244e0758641a:
>>
>>   tests: Make check-block a phony target (2019-04-09 18:34:21 +0200)
>>
>> ----------------------------------------------------------------
>> * fixes for Alpine and SuSE
>> * fix crash when hot-plugging nvdimm on older machine types
>>
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes.

The subject says 5.0 <:O) Hopefully Peter applied it for 4.0 :)

Thanks both for this PR,

Phil.
