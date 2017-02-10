Received: from eggs.gnu.org ([2001:4830:134:3::10]:33717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccGL4-00013Y-J8
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccGL2-0000An-Sr
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:54:34 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:32807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccGL2-0000AY-L2
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:54:32 -0500
Received: by mail-wr0-x229.google.com with SMTP id i10so114696390wrb.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 10:54:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <345b5ebd-6c7b-8234-c4bd-fb4c7ff0d0ec@redhat.com>
References: <20170210164825.9241-1-jsnow@redhat.com>
	<CAFEAcA9KV77e=fFkopiw9jC-ZVgKADQUC5=f8KGWOVcAU0cU3w@mail.gmail.com>
	<345b5ebd-6c7b-8234-c4bd-fb4c7ff0d0ec@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:54:10 +0000
Message-ID: <CAFEAcA-324yXHVsamSmaSrJfU2OQgy-xFh069nJoBJrSvsCZHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ladi Prosek <lprosek@redhat.com>

On 10 February 2017 at 18:46, John Snow <jsnow@redhat.com> wrote:
>
>
> On 02/10/2017 12:49 PM, Peter Maydell wrote:
>> On 10 February 2017 at 16:48, John Snow <jsnow@redhat.com> wrote:
>>> The following changes since commit 61eedf7aec0e2395aabd628cc055096909a3ea15:
>>>
>>>   tests/prom-env: Ease time-out problems on slow hosts (2017-02-10 15:44:53 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>>>
>>> for you to fetch changes up to 98cb5dccb192b0082626080890dac413473573c6:
>>>
>>>   ahci: advertise HOST_CAP_64 (2017-02-10 11:47:11 -0500)
>>>
>>> ----------------------------------------------------------------
>>>
>>> ----------------------------------------------------------------
>>
>> gpg: Signature made Fri 10 Feb 2017 16:47:54 GMT
>> gpg:                using RSA key 0x7DEF8106AAFC390E
>> gpg: Good signature from "John Snow (John Huston) <jsnow@redhat.com>"
>> gpg: Note: This key has expired!
>> Primary key fingerprint: FAEB 9711 A12C F475 812F  18F2 88A9 064D 1835 61EB
>>      Subkey fingerprint: F9B7 ABDB BCAC DF95 BE76  CBD0 7DEF 8106 AAFC 390E
>>
>> ...?
>>
>> thanks
>> -- PMM
>>
>
> [Discussed on IRC, but for the benefit of list archives;]
>
> My key expired after the holidays, but I've redone the expiry and
> re-pushed to public keyservers. Please refresh from the public keys list
> and let me know if you have further problems.

Yep, I refreshed the key and have now applied this to master.

thanks
-- PMM
