Received: from eggs.gnu.org ([2001:4830:134:3::10]:51822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZdgv-00071A-QB
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZdgs-00016D-Kx
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:18:49 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:35785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZdgs-00015R-FM
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:18:46 -0500
Received: by mail-pg0-x235.google.com with SMTP id d6so2269553pgv.2
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 06:18:46 -0800 (PST)
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
	<20180110015506.GO2131@umbus.fritz.box>
	<0b3ef6d4-0e2f-686a-a1ce-8f71ab1e10d4@redhat.com>
	<20180111024711.GF24770@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01c5621e-352c-1ce5-4289-2286c8139b7b@linaro.org>
Date: Thu, 11 Jan 2018 06:18:41 -0800
MIME-Version: 1.0
In-Reply-To: <20180111024711.GF24770@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, surajjs@au1.ibm.com, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org

On 01/10/2018 06:47 PM, David Gibson wrote:
> Ah.  But maybe a different version to older ARM32s?

No, the bug affected all arm32 back to the beginning of time.

> I'm trying to figure out why I entirely failed to reproduce this on a
> Raspberry Pi 1 (and a couple of other arm32 machines, but I forget the
> details of them).

I can't imagine, really.  You should have been able to see it there.


r~
