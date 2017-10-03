Received: from eggs.gnu.org ([2001:4830:134:3::10]:52431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dzFIZ-0004at-9a
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 00:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dzFIW-0001zY-6q
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 00:59:15 -0400
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:33621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1dzFIV-0001qx-Op
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 00:59:12 -0400
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-37-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <ac0f1b99-78a9-027d-b82a-45a741d091d5@reactos.org>
Date: Tue, 3 Oct 2017 06:59:01 +0200
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-37-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 36/38] mips: Magnum/Acer Pica 61: replace
 cpu_model with cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, aurelien@aurel32.net, yongbok.kim@imgtec.com

Le 02/10/2017 à 11:08, Igor Mammedov a écrit :
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: hpoussin@reactos.org
> CC: aurelien@aurel32.net
> CC: yongbok.kim@imgtec.com
> ---
>   hw/mips/mips_jazz.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
