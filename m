Received: from eggs.gnu.org ([209.51.188.92]:34271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmihd-0003au-5w
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmihc-0008Iq-JY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:22:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmihc-0008Hb-DW
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:22:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so7359107wrw.5
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 09:22:08 -0800 (PST)
References: <1548343154-8774-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab58e4b3-0383-7bee-69d3-989a507f6909@redhat.com>
Date: Thu, 24 Jan 2019 18:22:05 +0100
MIME-Version: 1.0
In-Reply-To: <1548343154-8774-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/3] tests: Reorganize MIPS TCG
 directories and files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 1/24/19 4:19 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Reorganize MIPS TCG directories and files. 
[...]
>  496 files changed, 193 insertions(+), 13685 deletions(-)

O_o
