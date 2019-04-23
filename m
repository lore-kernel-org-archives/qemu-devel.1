Received: from eggs.gnu.org ([209.51.188.92]:57285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1hItAJ-0007GU-PK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1hIt8Y-0007WR-0t
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:58:54 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:51911
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chouteau@adacore.com>)
	id 1hIt8X-0007Td-RG
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:58:53 -0400
References: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
	<1555669092-10351-2-git-send-email-frederic.konrad@adacore.com>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <92f9bdab-36af-d76a-02b4-0ea2610b7498@adacore.com>
Date: Tue, 23 Apr 2019 12:58:47 +0200
MIME-Version: 1.0
In-Reply-To: <1555669092-10351-2-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1 1/3] leon3: add a little bootloader
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
> This adds a little bootloader to the leon3_machine when a ram image is
> given through the kernel parameter and no bios are provided:
>   * The UART transmiter is enabled.
>   * The TIMER is initialized.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
