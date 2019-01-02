Received: from eggs.gnu.org ([208.118.235.92]:55186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1geebT-0005xP-2v
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1geebN-0003FE-Tj
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:22:25 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrew@aj.id.au>) id 1geebN-0003EM-EU
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:22:21 -0500
Message-Id: <1546428136.1511068.1623418624.167C3723@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
Date: Wed, 02 Jan 2019 21:52:16 +1030
In-Reply-To: <20190102110612.20387-1-joel@jms.id.au>
References: <20190102110612.20387-1-joel@jms.id.au>
Subject: Re: [Qemu-devel] [PATCH] gitdm: Add other IBMers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, =?utf-8?Q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On Wed, 2 Jan 2019, at 21:36, Joel Stanley wrote:
> Here are some IBMers who use their personal addresses when submitting
> patches.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

For the addition of my address:

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  contrib/gitdm/group-map-ibm | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
> index b66db5f4a825..6c0570107d65 100644
> --- a/contrib/gitdm/group-map-ibm
> +++ b/contrib/gitdm/group-map-ibm
> @@ -2,5 +2,10 @@
>  # Some IBM contributors submit via another domain
>  #
>  
> +aik@ozlabs.ru
> +andrew@aj.id.au
> +benh@kernel.crashing.org
>  clg@kaod.org
>  groug@kaod.org
> +joel@jms.id.au
> +sjitindarsingh@gmail.com
> -- 
> 2.19.1
> 
