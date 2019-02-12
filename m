Received: from eggs.gnu.org ([209.51.188.92]:35586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtVJB-0007eP-6H
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtVJ9-0007V9-9j
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:28:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gtVJ7-0007D5-D8
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:28:54 -0500
Date: Tue, 12 Feb 2019 11:28:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190212112834.3af78ea2.cohuck@redhat.com>
In-Reply-To: <20190212095749.20313-1-pbonzini@redhat.com>
References: <20190212095749.20313-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Tue, 12 Feb 2019 10:57:49 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/kconfig.rst | 305 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 305 insertions(+)
>  create mode 100644 docs/devel/kconfig.rst

Looks good!

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
