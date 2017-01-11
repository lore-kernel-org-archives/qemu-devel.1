Received: from eggs.gnu.org ([2001:4830:134:3::10]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8bG-0004K8-7L
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8bF-0008EO-Eo
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:25:18 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <148294246378.10801.8881527920302104439.stgit@fimbulvetr.bsc.es>
	<148294246924.10801.16850780392122412532.stgit@fimbulvetr.bsc.es>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9fc6043f-fdb5-0212-a76d-c3383dcd76ff@twiddle.net>
Date: Tue, 10 Jan 2017 18:25:09 -0800
MIME-Version: 1.0
In-Reply-To: <148294246924.10801.16850780392122412532.stgit@fimbulvetr.bsc.es>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 1/6] Pass generic CPUState to
 gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Jia Liu <proljc@gmail.com>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Aurelien Jarno <aurelien@aurel32.net>

On 12/28/2016 08:27 AM, Lluís Vilanova wrote:
> Needed to implement a target-agnostic gen_intermediate_code() in the
> future.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
