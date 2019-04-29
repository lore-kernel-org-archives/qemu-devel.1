Received: from eggs.gnu.org ([209.51.188.92]:45648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1hL8k0-0003yX-Bw
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1hL8jy-0005Vq-Aj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:02:52 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:40333)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1hL8jw-0005Pa-Bk
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:02:48 -0400
References: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
	<CAFEAcA_X+rmREYo_HRjKwwNmUGG4vEeb6s=5eLb3MudmEsUH=A@mail.gmail.com>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <4e91e256-a8dc-930d-fc10-bc2b01f4d6ce@codesourcery.com>
Date: Mon, 29 Apr 2019 10:02:38 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_X+rmREYo_HRjKwwNmUGG4vEeb6s=5eLb3MudmEsUH=A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 0/2] Nios II generic board config and
 semihosting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

On 4/29/19 9:55 AM, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 20:53, Sandra Loosemore <sandra@codesourcery.com> wrote:
>>
>> This is the seventh version of the patch series last posted here:
>> http://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg06255.html
>>
>> Changes since v6:
>> - Fixed block comment formatting for QEMU style.
>> - Fixed fixme for interrupt handler (now added to libgloss BSP).
>> - Added link to libgloss semihosting documentation.
>>
>> Sandra Loosemore (2):
>>    Add generic Nios II board.
>>    Add Nios II semihosting support.
> 
> Since Nios II doesn't have anybody actively handling
> pull requests for it right now, I've applied these patches
> directly to master -- thanks!

Thank you for taking care of this!

-Sandra
