Received: from eggs.gnu.org ([2001:4830:134:3::10]:38666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duf5L-00065y-S3
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duf5H-0006YS-Si
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:30:39 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:48570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duf5H-0006VX-Pd
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:30:35 -0400
Received: by mail-qt0-x230.google.com with SMTP id q8so2750466qtb.5
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:30:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170917232010.14183-1-f4bug@amsat.org>
	<20170917232010.14183-7-f4bug@amsat.org>
	<20170920112116.6885549f@nial.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4ca9137f-dc5c-0ecd-9a28-b5338b337584@amsat.org>
Date: Wed, 20 Sep 2017 08:38:39 -0300
MIME-Version: 1.0
In-Reply-To: <20170920112116.6885549f@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 6/6] mips: replace cpu_mips_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>

On 09/20/2017 06:21 AM, Igor Mammedov wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
> Hi Philippe,
> 
> since series were sitting unmerged on list for a long time
> path won't apply due to context changes on top of
>   [PATCH v2 0/5] generalize parsing of cpu_model  (x86/arm)
> for which Eduardo posted pull req yesterday.

Thanks to notify me, I didn't notice!

> Could you rebase this patch on top of pull req
> (it's only this one patch, the rest applies fine)

Sure :)
