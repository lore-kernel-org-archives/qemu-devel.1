Received: from eggs.gnu.org ([2001:4830:134:3::10]:36774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1C8-0005KW-LB
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1C4-0006u5-2I
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:06:28 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:33168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1C3-0006tS-SG
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:06:23 -0400
Received: by mail-pg0-x22f.google.com with SMTP id t3so832252pgt.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:06:23 -0700 (PDT)
References: <cover.1504222314.git.alistair.francis@xilinx.com>
	<CAFEAcA8TSpNkz3ew+wk6K0vu18B5RCr=0vbkihcaDz8v2zUN8g@mail.gmail.com>
	<CAKmqyKMd0JcEtkqiajLd5sbWP9WpjS8XqwfGGWPuANchE5Ej3A@mail.gmail.com>
	<CAKmqyKPSm4UHL7K0ZBGF28Z+wZ0qtMLd7CSvF9W94LwsXfN9zQ@mail.gmail.com>
	<CAFEAcA_0FyFFqJ2GOtUw5CPBKTj1YR9ykroyL-7WCYfbgR0hAg@mail.gmail.com>
	<CAKmqyKOqOJJceCf-wMjZTMQCHDjHWGWT4JAdsqERVXeNtTP6dw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57594b14-dbe1-9542-6bdb-eb0b5dc1314a@linaro.org>
Date: Thu, 7 Sep 2017 11:06:19 -0700
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOqOJJceCf-wMjZTMQCHDjHWGWT4JAdsqERVXeNtTP6dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 09/07/2017 09:48 AM, Alistair Francis wrote:
> Hmmm... I'm not sure how to look into this then, as I can see the
> patches going through to my personal email address, so it's hard to
> place the blame on the Xilinx mail server.
> 
> Do you want me to try sending out patches 1 and 3 again?

I had this problem with one of my patch sets earlier this year.
In the end it seemed easier to post a link to a public git tree.


r~
