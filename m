Received: from eggs.gnu.org ([2001:4830:134:3::10]:44314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWXY7-0007ho-OB
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 20:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWXY7-00039u-1I
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 20:08:55 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<CAKmqyKNDbhAQWXYPrhFnbqcCRDO_ZeBdUuC_xna9XpqCvw452g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <31aa78d3-5bd3-0495-8f9e-795efebdd69d@amsat.org>
Date: Tue, 2 Jan 2018 22:08:44 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNDbhAQWXYPrhFnbqcCRDO_ZeBdUuC_xna9XpqCvw452g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/42] SDHCI: housekeeping,
 add a qtest and fix few issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?Q?Gr=c3=a9gory_Estrade?= <gregory.estrade@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 01/02/2018 09:15 PM, Alistair Francis wrote:
> We are making progress here. Do you think it would be worth splitting
> out the earlier patches that have been reviewed so far so they can be
> merged? A 42 patch series it pretty daunting and most of the first 20
> are pretty straightforward and have been reviewed.

Andreas or Eduardo could you help reviewing patches 4-7 please? These
are QOM-related changes.

Thanks!

Phil.
