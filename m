Received: from eggs.gnu.org ([2001:4830:134:3::10]:45743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gXZpj-00044e-Hg
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gXZpi-0003z6-P4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:51:55 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181213223737.11793-1-pbonzini@redhat.com>
	<20181213223737.11793-2-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <850d1216-a4b7-e110-e9b9-e1beaeeaf6fc@twiddle.net>
Date: Thu, 13 Dec 2018 16:51:42 -0600
MIME-Version: 1.0
In-Reply-To: <20181213223737.11793-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] remove space-tab sequences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "open list:ARM target" <qemu-arm@nongnu.org>

On 12/13/18 4:37 PM, Paolo Bonzini wrote:
> There are not many, and they are all simple mistakes that ended up
> being committed.  Remove them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
