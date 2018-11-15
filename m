Received: from eggs.gnu.org ([2001:4830:134:3::10]:56955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNPC1-0000pK-TU
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNPBy-0001f4-Lp
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:28:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gNPBy-0001by-G1
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:28:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so22743392wre.1
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 13:28:35 -0800 (PST)
References: <20181115211752.1295571-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6b396af0-d76e-cfcf-d312-e0db272f97d5@redhat.com>
Date: Thu, 15 Nov 2018 22:28:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181115211752.1295571-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] typedefs.h cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com

On 15/11/18 22:17, Eric Blake wrote:
> Prompted by my review of xiezhide's work.  No semantic change, but
> not technically a bug fix, so I don't care if it goes in 3.1 or
> waits for 4.0.
> 
> Eric Blake (2):
>    typedefs: (Re-)sort entries alphabetically
>    numa: Match struct to typedef name

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
