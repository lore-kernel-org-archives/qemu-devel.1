Received: from eggs.gnu.org ([2001:4830:134:3::10]:52915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5ju-0004N5-Gf
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL5jr-0007I1-Bm
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:46:02 -0400
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-3-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <75472990-20b9-15fc-3b4b-1d2c0342f71d@redhat.com>
Date: Tue, 22 May 2018 13:45:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180522104000.9044-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/5] hw/i386: Rename 2.13
 machine types to 3.0
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
> Rename the 2.13 machine types to match what we're going to
> use as our next release number.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/i386/pc_piix.c | 8 ++++----
>  hw/i386/pc_q35.c  | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
