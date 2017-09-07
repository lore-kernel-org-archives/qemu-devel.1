Received: from eggs.gnu.org ([2001:4830:134:3::10]:37613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dq1ET-0006s3-2w
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dq1EO-0000uI-CL
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:08:53 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:44205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dq1EO-0000tg-4Z
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:08:48 -0400
Received: by mail-wm0-x22f.google.com with SMTP id 137so773216wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:08:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57594b14-dbe1-9542-6bdb-eb0b5dc1314a@linaro.org>
References: <cover.1504222314.git.alistair.francis@xilinx.com>
	<CAFEAcA8TSpNkz3ew+wk6K0vu18B5RCr=0vbkihcaDz8v2zUN8g@mail.gmail.com>
	<CAKmqyKMd0JcEtkqiajLd5sbWP9WpjS8XqwfGGWPuANchE5Ej3A@mail.gmail.com>
	<CAKmqyKPSm4UHL7K0ZBGF28Z+wZ0qtMLd7CSvF9W94LwsXfN9zQ@mail.gmail.com>
	<CAFEAcA_0FyFFqJ2GOtUw5CPBKTj1YR9ykroyL-7WCYfbgR0hAg@mail.gmail.com>
	<CAKmqyKOqOJJceCf-wMjZTMQCHDjHWGWT4JAdsqERVXeNtTP6dw@mail.gmail.com>
	<57594b14-dbe1-9542-6bdb-eb0b5dc1314a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 19:08:26 +0100
Message-ID: <CAFEAcA8e9c_kB8b-LEWNGDPoyPfrEHp4_z9cCK70gPzcaV4Wrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Expose the secure and virt
 properties to the
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 7 September 2017 at 19:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 09/07/2017 09:48 AM, Alistair Francis wrote:
>> Hmmm... I'm not sure how to look into this then, as I can see the
>> patches going through to my personal email address, so it's hard to
>> place the blame on the Xilinx mail server.
>>
>> Do you want me to try sending out patches 1 and 3 again?
>
> I had this problem with one of my patch sets earlier this year.
> In the end it seemed easier to post a link to a public git tree.

Being on the direct cc list I get all the patches anyway, so
it's mostly an issue for (1) review by other people not directly
cc'd and (2) the automated tools (I can apply stuff by hand from
direct email but it's a pain as I have to manually save and
then git am every email in the set).

thanks
-- PMM
