Received: from eggs.gnu.org ([2001:4830:134:3::10]:58206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5Yn3-0003Ip-LF
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5Yn0-0000iK-IL
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:33:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5Yn0-0000hl-E5
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:33:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 466A34040074
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 15:33:01 +0000 (UTC)
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<20180307151836.GK20201@redhat.com>
	<20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>
	<20180308101728.GG4718@redhat.com>
	<f30635f1-5773-2046-1efd-fc37a0a49753@redhat.com>
	<85d1416c-c442-eaf2-c4a5-3308fd63de3a@redhat.com>
	<721a331e-0ba9-58e2-8659-81b725a0ddff@redhat.com>
	<20180409090244.GP9903@paraplu>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <25fb31d4-0ba4-a827-59f5-76f838a36f8b@redhat.com>
Date: Mon, 9 Apr 2018 17:32:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180409090244.GP9903@paraplu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On 04/09/18 11:02, Kashyap Chamarthy wrote:

>   - It also provides a persistent command history in a convenient file:
>     '~/.qmp-shell_history'

I noticed it used readline, but I didn't know about the dedicated
history file. Nice! Thanks!

Laszlo
