Received: from eggs.gnu.org ([2001:4830:134:3::10]:58204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dttmZ-00019o-9B
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dttmT-0005O1-F7
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:00:07 -0400
References: <20170917232842.14544-1-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <17911dc7-9326-66c6-7b94-8e59d06d2af2@vivier.eu>
Date: Mon, 18 Sep 2017 12:59:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170917232842.14544-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qom/cpu: move cpu_model null check to
 cpu_class_by_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Chris Wulff <crwulff@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, Peter Maydell <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Le 18/09/2017 à 01:28, Philippe Mathieu-Daudé a écrit :
> and clean every implementation.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Based-on: 20170917232010.14183-7-f4bug@amsat.org

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
