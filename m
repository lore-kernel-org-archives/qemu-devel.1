Received: from eggs.gnu.org ([2001:4830:134:3::10]:45996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebiPR-00046c-3w
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 02:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebiPM-0004RA-Um
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 02:45:21 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:63622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ebiPM-0004Ns-HH
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 02:45:16 -0500
References: <20180113144847.8403-1-laurent@vivier.eu>
	<20180113144847.8403-4-laurent@vivier.eu>
	<CAKcpw6WCjeo-G-kHeiHbUEPAOYCGkjojG69YFjzkzLC9vyXa6Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e6596037-467c-60c0-f5d6-d29a3e560e22@vivier.eu>
Date: Wed, 17 Jan 2018 08:44:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAKcpw6WCjeo-G-kHeiHbUEPAOYCGkjojG69YFjzkzLC9vyXa6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] linux-user: MIPS set cpu to r6 CPU if
 binary is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: YunQiang Su <syq@debian.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aaron Sierra <asierra@xes-inc.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 17/01/2018 à 03:26, YunQiang Su a écrit :
> On Sat, Jan 13, 2018 at 10:48 PM, Laurent Vivier <laurent@vivier.eu> wrote:
>> From: YunQiang Su <syq@debian.org>
>>
>> So here we need to detect the version of binaries and set
>> cpu_model for it.
>>
>> [lv: original patch modified to move code into get_cpu_model()]
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>
>> Notes:
>>     YunQiang Su, please add your Signed-off-by that was
>>     missing in your original patch.
> 
> How to add Signed-off-by? Send a v2 for my version of patch?

You can reply to your original patch with your "Signed-off-by".
And as I did some changes in the following series, it would be good to
reply with a "Reviewed-by" to the new patches if you agree with the changes.

Thanks,
Laurent
