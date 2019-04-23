Received: from eggs.gnu.org ([209.51.188.92]:48343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hIyIb-0004O9-29
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hIyFq-00057i-M1
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:26:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hIyFq-00057R-EG
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:26:46 -0400
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-3-liq3ea@163.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <23d57c5a-7cbc-4f7c-a02e-771f4f24ef00@redhat.com>
Date: Tue, 23 Apr 2019 18:26:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190420100056.116305-3-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] tests: fw_cfg: add a function to get
 the fw_cfg file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, lvivier@redhat.com, pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

On 20/04/2019 12.00, Li Qiang wrote:
> This is useful to write qtest about fw_cfg file entry.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/libqos/fw_cfg.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  tests/libqos/fw_cfg.h |  2 ++
>  2 files changed, 47 insertions(+)

Acked-by: Thomas Huth <thuth@redhat.com>
