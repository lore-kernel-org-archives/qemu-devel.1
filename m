Received: from eggs.gnu.org ([209.51.188.92]:57308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFhIP-0008Rw-73
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFhIO-0002gQ-Ci
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:43:53 -0400
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-3-git-send-email-atar4qemu@gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <840bd92e-096e-406c-0c48-2067ac9f5b0f@reactos.org>
Date: Sun, 14 Apr 2019 17:43:48 +0200
MIME-Version: 1.0
In-Reply-To: <1555103178-21894-3-git-send-email-atar4qemu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] 40p and prep: implement PCI bus
 mastering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   hw/pci-host/prep.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
