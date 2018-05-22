Received: from eggs.gnu.org ([2001:4830:134:3::10]:53465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5m6-0005hl-Sr
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5m6-00089j-7X
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:48:18 -0400
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-5-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <77211f20-cd09-8bc8-ad36-d69468c32d03@redhat.com>
Date: Tue, 22 May 2018 13:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180522104000.9044-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 4/5] ppc: Rename 2.13 machines
 to 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 22.05.2018 12:39, Peter Maydell wrote:
> Rename the 2.13 machines to match the number we're going to
> use for the next release.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/ppc/cpu.h                |  2 +-
>  hw/ppc/spapr.c                  | 14 +++++++-------
>  target/ppc/machine.c            |  8 ++++----
>  target/ppc/translate_init.inc.c |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
