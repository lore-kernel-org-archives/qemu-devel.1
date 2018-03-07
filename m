Received: from eggs.gnu.org ([2001:4830:134:3::10]:54478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eti06-0000ko-6J
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eti03-0008Fi-55
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:57:34 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eti02-0008EG-Ue
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:57:31 -0500
Received: by mail-wm0-x22b.google.com with SMTP id e194so7804689wmd.3
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 14:57:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <23118.27370.136663.284087@guava.gson.org>
	<143c7064-8a4d-6f78-6d50-ed10096ddd3b@gmx.com>
	<5b3a1a64-2960-d120-08f4-e32227df2712@amsat.org>
	<20180307223433.davsfc42oll6e3er@var.youpi.perso.aquilenet.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <991c562c-692d-c632-4ed4-ac85b27f0e1f@amsat.org>
Date: Wed, 7 Mar 2018 19:57:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180307223433.davsfc42oll6e3er@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: disable Nagle in outgoing
 connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Kamil Rytarowski <n54@gmx.com>, Andreas Gustafsson <gson@gson.org>, qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>

On 03/07/2018 07:34 PM, Samuel Thibault wrote:
> Hello,
> 
> Thanks for the Cc.
> 
> I have applied it to my tree.  I don't think there is any reason to
> avoid the same change for ingoing connections?  Could one of your review
> the attached patch doing it?

attached patch:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Samuel
> 
