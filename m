Received: from eggs.gnu.org ([2001:4830:134:3::10]:48833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEZu5-0007VY-36
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEZty-00055t-Vn
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:05:52 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:55546)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEZtv-00051W-Kf
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:05:46 -0400
References: <20181022084824.555-1-maozhongyi@cmss.chinamobile.com>
	<20181022084824.555-3-maozhongyi@cmss.chinamobile.com>
	<c3308f3b-50c4-2b15-f117-816ba326ef5f@redhat.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <9e4affdb-7a97-95ed-2e5b-0720bbc46eb4@cmss.chinamobile.com>
Date: Mon, 22 Oct 2018 21:05:35 +0800
MIME-Version: 1.0
In-Reply-To: <c3308f3b-50c4-2b15-f117-816ba326ef5f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] po/Makefile: Modern shell scripting
 (use $()instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, peter.maydell@linaro.org, sw@weilnetz.de



On 10/22/18 6:59 PM, Thomas Huth wrote:
> On 2018-10-22 09:48, Mao Zhongyi wrote:
>> Various shell files contain a mix between obsolete ``
>> and modern $(); It would be nice to convert to using $()
>> everywhere.
>>
>> Cc: philmd@redhat.com
>> Cc: peter.maydell@linaro.org
>> Cc: thuth@redhat.com
>> Cc: sw@weilnetz.de
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> That last line should be "Reviewed-by:" instead - but that can be fixed
> when the patch is picked up, no need to resend just because of this nit.

OK, just because I didn't explicitly get R-b. :)

Thanks,
Mao

> 
>   Thomas
> 
