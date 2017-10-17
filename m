Received: from eggs.gnu.org ([2001:4830:134:3::10]:51589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4LP0-0004dg-1t
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4LOx-0002q5-0Y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:30:58 -0400
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-38-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0f7d83c7-b814-0e07-a043-f4cd957136c6@redhat.com>
Date: Tue, 17 Oct 2017 08:30:45 +0200
MIME-Version: 1.0
In-Reply-To: <20171017001209.32276-38-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 37/39] i386/pc: extract port92 from pc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


Why are you doing this? I really fail to see the rationale here. Please
add proper patch descriptions!

 Thomas
