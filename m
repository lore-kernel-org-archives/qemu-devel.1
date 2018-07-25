Received: from eggs.gnu.org ([2001:4830:134:3::10]:53141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiJOY-0006b0-3i
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 09:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiJOV-00030y-6m
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:59:58 -0400
Date: Wed, 25 Jul 2018 14:59:44 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180725125944.5nd5ydm4x4e3vvjw@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
	<CAFEAcA8wi2QV9cVg_Hp=8MYw_zfxvVciR2CbRZiGJNiQNPdHqg@mail.gmail.com>
	<20180725124700.GF12855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180725124700.GF12855@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Wed, Jul 25, 2018 at 01:47:00PM +0100, Daniel P. Berrang=E9 wrote:
> Would iut make any sense to call the machine  "refplatform"  or "refboa=
rd"
> to indicate it is a generic reference platform, not specifically follow=
ing
> any particular real impl, albeit influence by the sbsa spec.
>

That would indeed stop me from whining about a machine model with an
'sbsa' name not strictly implementing a minimal SBSA machine :-)

drew
