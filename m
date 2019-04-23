Received: from eggs.gnu.org ([209.51.188.92]:57285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1hItAI-0007GU-Ku
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1hIt90-0007q9-Ed
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:59:23 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:43476
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chouteau@adacore.com>)
	id 1hIt8z-0007oP-6e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:59:21 -0400
References: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
	<1555669092-10351-3-git-send-email-frederic.konrad@adacore.com>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <dac838c9-171c-d14e-c0ec-0d3f16d2b7ed@adacore.com>
Date: Tue, 23 Apr 2019 12:59:15 +0200
MIME-Version: 1.0
In-Reply-To: <1555669092-10351-3-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1 2/3] leon3: introduce the plug and play
 mecanism
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, philmd@redhat.com, atar4qemu@gmail.com

On 19/04/2019 12:18, KONRAD Frederic wrote:
> This adds the AHB and APB plug and play devices.
> They are scanned during the linux boot to discover the various peripheral.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
