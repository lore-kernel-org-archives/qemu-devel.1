Received: from eggs.gnu.org ([2001:4830:134:3::10]:36329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euJMd-0006uy-NP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euJMa-0000bS-Kr
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:51:19 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50017)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euJMa-0000bI-BH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:51:16 -0500
References: <20180309142630.2170-1-laurent@vivier.eu>
	<152060671798.1497.3007948970030778281@bdbb90650ae5>
	<CAFEAcA8GRaGrdbSczr51Z4mqGhL==9WgUJnN01ixOsA=BGMkiA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <47b820a7-ec36-89de-984a-8af895976fc0@vivier.eu>
Date: Fri, 9 Mar 2018 15:51:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8GRaGrdbSczr51Z4mqGhL==9WgUJnN01ixOsA=BGMkiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/8] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>

Le 09/03/2018 à 15:50, Peter Maydell a écrit :
> On 9 March 2018 at 14:45,  <no-reply@patchew.org> wrote:
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
> 
>> Checking PATCH 2/8: target/m68k: implement flognp1...
>> ERROR: do not set execute permissions for source files
>> #281: FILE: target/m68k/softfloat_fpsp_tables.h
>>
>> total: 1 errors, 0 warnings, 408 lines checked
> 
> Oops. Could you fix the file permissions and resend, please,
> Laurent ?

Yes, I'm doing that now.

Thanks,
Laurent
