Received: from eggs.gnu.org ([2001:4830:134:3::10]:52398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fiFih-0003dG-GX
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fiFie-00017T-G1
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:04:31 -0400
MIME-Version: 1.0
In-Reply-To: <20180725085944.11856-1-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 25 Jul 2018 10:04:26 +0100
Message-ID: <CAJSP0QVAAD9pyxJ_gocLVNt7DOkcJsqgMwm5vvJjVaVfa5yp9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/7] arm: add Cortex M0 CPU model and
 hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Su Hang <suhang16@mails.ucas.ac.cn>, Liviu Ionescu <ilg@livius.net>, Alistair Francis <alistair@alistair23.me>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

Based-on: https://git.linaro.org/people/pmaydell/qemu-arm.git target-arm.for-3.1
