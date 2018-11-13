Received: from eggs.gnu.org ([2001:4830:134:3::10]:35218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMc9f-0006SB-Nt
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMc3b-0002dB-3w
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:00:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMc3a-000208-Sg
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:00:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so12779089wmw.0
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 09:00:24 -0800 (PST)
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-2-sameo@linux.intel.com>
	<CAFEAcA-npVS1Q0=or=p-kjP0Nf4h1n+qUL7y8+yYCdtuHa7Fxg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60aa686a-89b3-4b98-604a-0168fa8419c0@redhat.com>
Date: Tue, 13 Nov 2018 18:00:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-npVS1Q0=or=p-kjP0Nf4h1n+qUL7y8+yYCdtuHa7Fxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/13] target: arm: Add copyright
 boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 13/11/18 17:58, Peter Maydell wrote:
> On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
>> Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>>   target/arm/helper.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 0da1424f72..3d4e9c5c8a 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -1,3 +1,10 @@
>> +/*
>> + * ARM generic helpers.
>> + *
>> + * This code is licensed under the GNU GPL v2.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
> 
> The human readable text says "v2", but the SPDX tag says
> "v2 or later". Which is right? (The top level LICENSE file says
> source files with no specific license are 2-or-later).

Sorry, the human failed, the machine is right.
